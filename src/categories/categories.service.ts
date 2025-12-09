import { Injectable, NotFoundException } from '@nestjs/common';
import { InjectRepository } from '@nestjs/typeorm';
import { Repository } from 'typeorm';
import { CategoryEntity } from './entities/category.entity';
import { CreateCategoryDto } from './dto/create-category.dto';
import { UpdateCategoryDto } from './dto/update-category.dto';

@Injectable()
export class CategoriesService {
  constructor(
    @InjectRepository(CategoryEntity)
    private categoriesRepository: Repository<CategoryEntity>,
  ) {}

  async create(createCategoryDto: CreateCategoryDto): Promise<CategoryEntity> {
    const category = this.categoriesRepository.create(createCategoryDto);
    return this.categoriesRepository.save(category);
  }

  async findAll(): Promise<CategoryEntity[]> {
    return this.categoriesRepository.find({
      relations: ['posts'],
    });
  }

  async findById(id: string): Promise<CategoryEntity> {
    const category = await this.categoriesRepository.findOne({
      where: { id },
      relations: ['posts'],
    });
    if (!category) {
      throw new NotFoundException(`Category with ID ${id} not found`);
    }
    return category;
  }

  async update(id: string, updateCategoryDto: UpdateCategoryDto): Promise<CategoryEntity> {
    await this.categoriesRepository.update(id, updateCategoryDto);
    return this.findById(id);
  }

  async remove(id: string): Promise<void> {
    const category = await this.findById(id);
    await this.categoriesRepository.remove(category);
  }
}
