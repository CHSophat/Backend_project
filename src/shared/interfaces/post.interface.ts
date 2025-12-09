export interface IPost {
  id: string;
  title: string;
  content: string;
  summary?: string;
  featuredImage?: string;
  published: boolean;
  viewCount: number;
  createdAt: Date;
  updatedAt: Date;
  authorId: string;
  categoryId?: string;
}
