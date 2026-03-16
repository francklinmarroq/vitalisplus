import type { Test } from '@/types/test'
import { testsService } from '~/services/testsService'

export function useCurrencies() {
  const tests = ref<Test[]>([])
  const loading = ref(false)
  const error = ref<string | null>(null)

  async function fetchAll() {
    loading.value = true
    error.value = null
    try {
      const data = await testsService.getAll()
      tests.value = data.map(c => ({ ...c }))
    }
    catch (err: any) {
      error.value = err.message
    }
    finally {
      loading.value = false
    }
  }

  fetchAll()

  return { tests, loading, error, fetchAll }
}
