import { Api } from 'telegram'
import { tgcalls } from '../../tgcalls'
import { queues } from '../queues'

export default async function stop(chatId: number) {
  queues.clear(chatId)
  try {
    return await tgcalls(chatId).stop()
  } catch (err) {
    if (err instanceof Api.RpcError) {
      if (err.errorMessage == 'GROUPCALL_FORBIDDEN') {
        return true
      }
    }
  }
  return null
}
