import { Entity, PrimaryGeneratedColumn, Column, CreateDateColumn, UpdateDateColumn } from 'typeorm';

@Entity()
export class Site {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ type: 'varchar', length: 255 })
  site_name: string;

  @Column('text')
  site_desc: string;

  @Column('text')
  site_address: string;

  @Column({ type: 'varchar', length: 50, nullable: true })
  site_tel: string;

  @Column({ type: 'time', nullable: true })
  site_open_time: string;

  @Column({ type: 'time', nullable: true })
  site_close_time: string;

  @Column({ type: 'varchar', length: 50, nullable: true })
  location_type: string;

  @Column('decimal', { precision: 10, scale: 8, nullable: true })
  latitude: number;

  @Column('decimal', { precision: 11, scale: 8, nullable: true })
  longitude: number;

  @CreateDateColumn({ type: 'timestamp' })
  created_at: Date;

  @UpdateDateColumn({ type: 'timestamp', onUpdate: 'CURRENT_TIMESTAMP' })
  updated_at: Date;
}
