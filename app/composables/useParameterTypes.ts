import type { ParameterType } from '~/types/parameterType'
import { parameterTypesService } from '~/services/parameterTypesService'

export function useParameterTypes() {
  const parameterTypes = ref<ParameterType[]>([])
  const loadingFetchParameterTypes = ref(false)
  const error = ref<string | null>(null)

  async function fetchAllParameterTypes() {
    loadingFetchParameterTypes.value = true
    error.value = null
    try {
      const data = await parameterTypesService.getAll() as ParameterType[]
      parameterTypes.value = data
    }
    catch (err: any) {
      error.value = err.message
    }
    finally {
      loadingFetchParameterTypes.value = false
    }
  }

  return { parameterTypes, loadingFetchParameterTypes, error, fetchAllParameterTypes }
}
