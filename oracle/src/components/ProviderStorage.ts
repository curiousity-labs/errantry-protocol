import RedisProvider from "./ProviderRedis"
import DatabaseProvider from "./ProviderRedis"
import { Queue, Worker } from "bullmq"

const mainQueue = new Queue("MainQueue")

export default class ProviderStorage {
  redisProvider: any
  databaseProvider: any

  constructor() {
    this.redisProvider = new RedisProvider()
    this.databaseProvider = new DatabaseProvider()
  }

  async addJob(jobName: string, data: any) {
    await mainQueue.add(jobName, data)
  }
}
