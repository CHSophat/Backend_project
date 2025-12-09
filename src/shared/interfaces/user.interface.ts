export interface IUser {
  id: string;
  email: string;
  firstName: string;
  lastName: string;
  bio?: string;
  profilePicture?: string;
  role: string;
  isActive: boolean;
  createdAt: Date;
  updatedAt: Date;
}
