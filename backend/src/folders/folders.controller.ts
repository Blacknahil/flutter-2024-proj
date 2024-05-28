import { Controller, Get, Post, Body, Patch, Param, Delete, Req } from '@nestjs/common';
import { FoldersService } from './folders.service';
import { CreateFolderDto } from './dto/create-folder.dto';
import { UpdateFolderDto } from './dto/update-folder.dto';
import { Types } from 'mongoose';

@Controller('folders')
export class FoldersController {
  constructor(private readonly foldersService: FoldersService) {}

  @Post(':userId')
  create(@Body() createFolderDto: CreateFolderDto,@Param('userId') userId:Types.ObjectId) {
    return this.foldersService.create(createFolderDto,userId);
  }

  // @Get()
  // findAll() {
  //   return this.foldersService.findAll();
  // }

  // @Get(':id')
  // findOne(@Param('id') id: string) {
  //   return this.foldersService.findOne(+id);
  // }

  @Patch(':id')
  update(@Param('id') id: string, @Body() updateFolderDto: UpdateFolderDto) {
    return this.foldersService.update(id, updateFolderDto);
  }

  @Delete(':folderId')
  async remove(@Param('folderId') folderId: string,@Body("userId") userId:string) {
    await this.foldersService.removeFolder(folderId,userId);

    console.log("Folder deleted successfully");
  }
}
