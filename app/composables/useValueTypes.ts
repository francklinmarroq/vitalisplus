import type { ValueType } from '~/types/valueType'
import { valueTypesService } from '~/services/valueTypesService'

export function useValueTypes() {
  const valueTypes = ref<ValueType[]>([])
  const loadingFetchValueTypes = ref(false)
  const error = ref<string | null>(null)

  async function fetchAllValueTypes() {
    loadingFetchValueTypes.value = true
    error.value = null
    try {
      const data = await valueTypesService.getAll()
      valueTypes.value = data
    }
    catch (err: any) {
      error.value = err.message
    }
    finally {
      loadingFetchValueTypes.value = false
    }
  }

  return { valueTypes, loadingFetchValueTypes, error, fetchAllValueTypes }
}
