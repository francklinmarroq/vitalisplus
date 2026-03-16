import type { TestType } from '@/types/testType'
import { testTypesService } from '~/services/testTypesService'

export function useTestTypes() {
  const testTypes = ref<TestType[]>([])
  const loading = ref(false)
  const error = ref<string | null>(null)

  async function fetchAll() {
    loading.value = true
    error.value = null
    try {
      const data = await testTypesService.getAll()
      testTypes.value = data.map(c => ({ ...c }))
    }
    catch (err: any) {
      error.value = err.message
    }
    finally {
      loading.value = false
    }
  }

  fetchAll()

  return { testTypes, loading, error, fetchAll }
}
