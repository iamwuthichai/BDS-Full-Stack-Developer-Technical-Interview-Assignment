import { Module } from '@nestjs/common';
import { TypeOrmModule } from '@nestjs/typeorm';
import { DataSource } from 'typeorm';

import { AppController } from './app.controller';
import { AppService } from './app.service';
import { SitesModule } from './sites/sites.module';
import { Site } from './sites/entities/site.entity';

@Module({
  imports: [
    TypeOrmModule.forRoot({
      type: 'mysql',          // ใช้ MySQL
      host: 'localhost',      // ที่อยู่ของฐานข้อมูล
      port: 3306,             // พอร์ต MySQL (ค่าเริ่มต้นคือ 3306)
      username: 'root',       // ชื่อผู้ใช้ฐานข้อมูล
      password: '',   // รหัสผ่านฐานข้อมูล
      database: 'tracking_map',  // ชื่อฐานข้อมูล
      entities: [__dirname + '/**/*.entity{.ts,.js}'], // กำหนดตำแหน่งไฟล์เอนทิตี
      synchronize: true,      // ใช้ synchronize ให้ฐานข้อมูลปรับโครงสร้างให้ตรงกับโมเดล
    }),
    SitesModule
  ],
  controllers: [AppController],
  providers: [AppService],
})

export class AppModule {
  constructor(private dataSource: DataSource) {}
}