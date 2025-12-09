import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { CommentsService } from './comments.service';
import { CommentsController, CommentsBaseController } from './comments.controller';
import { CommentEntity } from './entities/comment.entity';

@Module({
  imports: [TypeOrmModule.forFeature([CommentEntity])],
  controllers: [CommentsController, CommentsBaseController],
  providers: [CommentsService],
  exports: [CommentsService],
})
export class CommentsModule {}
