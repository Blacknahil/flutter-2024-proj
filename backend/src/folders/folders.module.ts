import { forwardRef, Module } from '@nestjs/common';
import { FoldersService } from './folders.service';
import { FoldersController } from './folders.controller';
import { Note, NoteSchema } from 'src/notes/schemas/note.schema';
import { User, UserSchema } from 'src/users/schemas/user.schema';
import { FolderSchema } from './schemas/folder.schema';
import { MongooseModule } from '@nestjs/mongoose';
import { UsersService } from 'src/users/users.service';
import { NotesService } from 'src/notes/notes.service';
import { NotesModule } from 'src/notes/notes.module';

@Module({
  imports:[
    forwardRef(() => NotesModule),
    MongooseModule.forFeature([{ name: Note.name, schema: NoteSchema }]),
    MongooseModule.forFeature([{ name: User.name, schema: UserSchema }]),
    MongooseModule.forFeature([{ name: 'Folder', schema: FolderSchema }]) 
  ],

  controllers: [FoldersController],
  providers: [UsersService,FoldersService],
  exports:[FoldersService]
})
export class FoldersModule {}
