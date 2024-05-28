import { Module } from "@nestjs/common";
import { MongooseModule } from "@nestjs/mongoose";
import { Folder, FolderSchema } from "./folder.schema";
import { FoldersController } from "../folders.controller";
import { FoldersService } from "../folders.service";
import { UsersModule } from "src/users/users.module";
import { UsersService } from "src/users/users.service";
@Module({
    imports: [
        MongooseModule.forFeature([{ name: Folder.name, schema: FolderSchema }]) // Replace [name] with the actual model name and provide the schema
    ],
    controllers:[FoldersController],
    providers:[FoldersService,UsersModule,UsersService],

})
export class FoldersModule {}
