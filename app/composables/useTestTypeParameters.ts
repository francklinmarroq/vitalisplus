import type { TestTypeParameter } from '@/types/testTypeParameter'
import { testTypeParametersService } from '~/services/testTypeParametersService'

export function useTestTypeParameters() {
  const testTypeParameters = ref<TestTypeParameter[]>([])
  const loading = ref(false)
  const error = ref<string | null>(null)

  async function fetchAll() {
    loading.value = true
    error.value = null
    try {
      const data = await testTypeParametersService.getAll()
      testTypeParameters.value = data.map(c => ({ ...c, testTypeId: c.parameter_id, parameterId: c.parameter_id }))
    }
    catch (err: any) {
      error.value = err.message
    }
    finally {
      loading.value = false
    }
  }

  fetchAll()

  return { testTypeParameters, loading, error, fetchAll }
}
