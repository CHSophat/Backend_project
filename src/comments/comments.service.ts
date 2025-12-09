import { Injectable, NotFoundException, ForbiddenException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CommentEntity } from './entities/comment.entity';
import { CreateCommentDto } from './dto/create-comment.dto';
import { UpdateCommentDto } from './dto/update-comment.dto';

@Injectable()
export class CommentsService {
  constructor(
    @InjectRepository(CommentEntity)
    private commentsRepository: Repository<CommentEntity>,
  ) {}

  async create(postId: string, createCommentDto: CreateCommentDto, authorId: string): Promise<CommentEntity> {
    const comment = this.commentsRepository.create({
      ...createCommentDto,
      postId,
      authorId,
    });
    return this.commentsRepository.save(comment);
  }

  async findByPostId(postId: string): Promise<CommentEntity[]> {
    return this.commentsRepository.find({
      where: { postId },
      relations: ['author'],
      order: { createdAt: 'DESC' },
    });
  }

  async findById(id: string): Promise<CommentEntity> {
    const comment = await this.commentsRepository.findOne({
      where: { id },
      relations: ['author', 'post'],
    });
    if (!comment) {
      throw new NotFoundException(`Comment with ID ${id} not found`);
    }
    return comment;
  }

  async update(id: string, updateCommentDto: UpdateCommentDto, userId: string): Promise<CommentEntity> {
    const comment = await this.findById(id);

    if (comment.authorId !== userId) {
      throw new ForbiddenException('You can only update your own comments');
    }

    await this.commentsRepository.update(id, updateCommentDto);
    return this.findById(id);
  }

  async remove(id: string, userId: string): Promise<void> {
    const comment = await this.findById(id);

    if (comment.authorId !== userId) {
      throw new ForbiddenException('You can only delete your own comments');
    }

    await this.commentsRepository.remove(comment);
  }
}
