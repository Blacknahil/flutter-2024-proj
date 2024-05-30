import { Controller, Get, Post, Body, Patch, Param, Delete, Req, UseGuards } from '@nestjs/common';
import { FoldersService } from './folders.service';
import { CreateFolderDto } from './dto/create-folder.dto';
import { UpdateFolderDto } from './dto/update-folder.dto';
import { Types } from 'mongoose';
import { JwtAuthGuard } from 'src/auth/auth.guard';

@Controller('folders')
export class FoldersController {
  constructor(private readonly foldersService: FoldersService) {}


  @UseGuards(JwtAuthGuard)
  @Post(':userId')
  async create(@Body() createFolderDto: CreateFolderDto,@Param('userId') userId:String){
    console.log("folder is being created");
    const res=await this.foldersService.create(createFolderDto,userId.toString());
    console.log(res)
    return res
  }

  @UseGuards(JwtAuthGuard)
  @Get('all/:userId')
  async findAll(@Param('userId') userId:String) {
    return await this.foldersService. findAllFoldersByUserId(userId);
  }

  @UseGuards(JwtAuthGuard)
  @Get('one/:folderId')
  async findOne(@Param('folderId') folderId: string) {
    const res=await this.foldersService.findFolderById(folderId);
    return res;
  }

  @UseGuards(JwtAuthGuard)
  @Get('notes/:folderId')
  async findFolderNotes(@Param('folderId') folderId: string) {
    const res=await this.foldersService.findNotesByFolderId(folderId);
    console.log("One folder is {res}")
    return res;
  }

  @Patch(':id')
  async update(@Param('id') id: string, @Body() updateFolderDto: UpdateFolderDto) {
    return await this.foldersService.update(id, updateFolderDto);
  }

  @Delete(':folderId')
  async remove(@Param('folderId') folderId: string,@Body("userId") userId:string) {
    await this.foldersService.removeFolder(folderId,userId);

    console.log("Folder deleted successfully");
  }
}
