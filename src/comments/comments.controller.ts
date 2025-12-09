import { Controller, Get, Post, Body, Param, Put, Delete, UseGuards, Request } from '@nestjs/common';
import { CommentsService } from './comments.service';
import { CreateCommentDto } from './dto/create-comment.dto';
import { UpdateCommentDto } from './dto/update-comment.dto';
import { JwtAuthGuard } from '../auth/guards/jwt-auth.guard';

@Controller('posts/:postId/comments')
export class CommentsController {
  constructor(private readonly commentsService: CommentsService) {}

  @Post()
  @UseGuards(JwtAuthGuard)
  create(@Param('postId') postId: string, @Body() createCommentDto: CreateCommentDto, @Request() req: any) {
    return this.commentsService.create(postId, createCommentDto, req.user.id);
  }

  @Get()
  findAll(@Param('postId') postId: string) {
    return this.commentsService.findByPostId(postId);
  }
}

@Controller('comments')
export class CommentsBaseController {
  constructor(private readonly commentsService: CommentsService) {}

  @Get(':id')
  findOne(@Param('id') id: string) {
    return this.commentsService.findById(id);
  }

  @Put(':id')
  @UseGuards(JwtAuthGuard)
  update(@Param('id') id: string, @Body() updateCommentDto: UpdateCommentDto, @Request() req: any) {
    return this.commentsService.update(id, updateCommentDto, req.user.id);
  }

  @Delete(':id')
  @UseGuards(JwtAuthGuard)
  remove(@Param('id') id: string, @Request() req: any) {
    return this.commentsService.remove(id, req.user.id);
  }
}
