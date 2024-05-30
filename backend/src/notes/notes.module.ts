import { forwardRef, Module } from '@nestjs/common';
import { NotesController } from './notes.controller';
import { NotesService } from './notes.service';
import { MongooseModule } from '@nestjs/mongoose';
import { Note, NoteSchema } from './schemas/note.schema';
import { AuthService } from 'src/auth/auth.service';
import { UsersService } from 'src/users/users.service';
import { UserModule } from 'src/users/schemas/user.module';
import { User, UserSchema } from 'src/users/schemas/user.schema';
import { FolderSchema } from 'src/folders/schemas/folder.schema';
import { FoldersModule } from 'src/folders/folders.module';
import { FoldersService } from 'src/folders/folders.service';

@Module({
  imports: [
    forwardRef(() => FoldersModule),
    MongooseModule.forFeature([{ name: Note.name, schema: NoteSchema }]),
    MongooseModule.forFeature([{ name: User.name, schema: UserSchema }]),
    MongooseModule.forFeature([{ name: 'Folder', schema: FolderSchema }]) 
  ],
  controllers: [NotesController],
  providers: [NotesService, AuthService, UsersService, UserModule],
  exports: [NotesService],
})
export class NotesModule {}
