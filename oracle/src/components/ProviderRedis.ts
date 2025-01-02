import { config } from "./../../config"
import { createClient, RedisClientType } from "redis"

export default class ProviderRedis {
  private client: RedisClientType

  constructor() {
    this.client = createClient({
      url: config.redisURL,
    })

    this.client.on("error", (err: Error) => {
      console.error("Redis Client Error", err)
    })

    this.client.on("connect", () => {
      console.log("Connected to Redis")
    })
  }

  public async connect(): Promise<void> {
    await this.client.connect()
  }

  public async disconnect(): Promise<void> {
    await this.client.disconnect()
  }

  public async set(key: string, value: string): Promise<void> {
    await this.client.set(key, value)
  }

  public async get(key: string): Promise<string | null> {
    return await this.client.get(key)
  }

  // Add more methods as needed
}
