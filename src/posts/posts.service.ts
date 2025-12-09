import { Injectable, NotFoundException, ForbiddenException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { PostEntity } from './entities/post.entity';
import { CreatePostDto } from './dto/create-post.dto';
import { UpdatePostDto } from './dto/update-post.dto';

@Injectable()
export class PostsService {
  constructor(
    @InjectRepository(PostEntity)
    private postsRepository: Repository<PostEntity>,
  ) {}

  async create(createPostDto: CreatePostDto, authorId: string): Promise<PostEntity> {
    const post = this.postsRepository.create({
      ...createPostDto,
      authorId,
    });
    return this.postsRepository.save(post);
  }

  async findAll(published?: boolean): Promise<PostEntity[]> {
    const query = this.postsRepository.createQueryBuilder('post').leftJoinAndSelect('post.author', 'author').leftJoinAndSelect('post.category', 'category');

    if (published) {
      query.where('post.published = :published', { published: true });
    }

    return query.orderBy('post.createdAt', 'DESC').getMany();
  }

  async findById(id: string): Promise<PostEntity> {
    const post = await this.postsRepository.findOne({
      where: { id },
      relations: ['author', 'category', 'comments'],
    });
    if (!post) {
      throw new NotFoundException(`Post with ID ${id} not found`);
    }
    return post;
  }

  async update(id: string, updatePostDto: UpdatePostDto, userId: string): Promise<PostEntity> {
    const post = await this.findById(id);

    if (post.authorId !== userId) {
      throw new ForbiddenException('You can only update your own posts');
    }

    await this.postsRepository.update(id, updatePostDto);
    return this.findById(id);
  }

  async remove(id: string, userId: string): Promise<void> {
    const post = await this.findById(id);

    if (post.authorId !== userId) {
      throw new ForbiddenException('You can only delete your own posts');
    }

    await this.postsRepository.remove(post);
  }

  async incrementViewCount(id: string): Promise<void> {
    await this.postsRepository.increment({ id }, 'viewCount', 1);
  }
}
