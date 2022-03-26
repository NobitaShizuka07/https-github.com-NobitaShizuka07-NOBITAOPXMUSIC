import { Readable } from 'stream'
import { User } from '@grammyjs/types'

export type Readables = { audio?: Readable; video?: Readable }

export interface Item {
  getReadables: () => Promise<Readables> | Readables
  url: string
  title: string
  requester: User
}

export type NowHandler = (chatId: number, now: Item) => Promise<void>

class Queues {
  queues: Map<number, Item[]> = new Map()
  now: Map<number, Item> = new Map()
  nowHandlers: NowHandler[] = []

  addNowHandler = (handler: NowHandler) => this.nowHandlers.push(handler)

  setNow(chatId: number, item: Item) {
    this.now.set(chatId, item)
    this.nowHandlers.forEach(handler => handler(chatId, item))
  }

  rmNow = (chatId: number) => this.now.delete(chatId)

  getNow = (chatId: number) => this.now.get(chatId)

  getNext = (chatId: number) => this.queues.get(chatId)?.[0]

  push(chatId: number, item: Item) {
    const queue = this.queues.get(chatId)
    if (queue) {
      queue.push(item)
      return queue.length
    }
    this.queues.set(chatId, [item])
    return 1
  }

  get(chatId: number) {
    const queue = this.queues.get(chatId)
    this.rmNow(chatId)
    if (queue) {
      const item = queue.shift()
      if (item) {
        this.setNow(chatId, item)
      }
      return item
    }
  }

  getAll(chatId: number) {
    const queue = this.queues.get(chatId)
    if (queue) {
      return queue
    }
    return []
  }

  clear(chatId: number) {
    this.rmNow(chatId)
    if (this.queues.has(chatId)) {
      this.queues.set(chatId, [])
      return true
    }
    return false
  }

  suffle(chatId: number) {
    const now = this.getNow(chatId)
    if (!now || this.getAll(chatId).length == 0) {
      return false
    }
    this.push(chatId, now)
    const items = this.getAll(chatId)
    let currentIndex = items.length,
      randomIndex
    while (currentIndex != 0) {
      randomIndex = Math.floor(Math.random() * currentIndex)
      currentIndex--
      ;[items[currentIndex], items[randomIndex]] = [
        items[randomIndex],
        items[currentIndex],
      ]
    }
    this.queues.set(chatId, items)
    return this.get(chatId)!
  }
}

export const queues = new Queues()
