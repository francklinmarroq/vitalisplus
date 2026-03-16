import type { Parameter } from '~/types/parameter'
import { parametersService } from '~/services/parametersService'

export function useParameters() {
  const parameters = ref<Parameter[]>([])
  const loading = ref(false)
  const error = ref<string | null>(null)

  async function fetchAll() {
    loading.value = true
    error.value = null
    try {
      const data = await parametersService.getAll()
      parameters.value = data.map(c => ({
        ...c,
        valueTypeId: c.value_type_id,
        highExpectedValue: c.high_expected_value,
        lowExpectedValue: c.low_expected_value,
        referenceText: c.reference_text,
        unitId: c.unit_id,
        parameterTypeId: c.parameter_type_id,
        label: c.name,
      }))
    }
    catch (err: any) {
      error.value = err.message
    }
    finally {
      loading.value = false
    }
  }

  fetchAll()

  return { parameters, loading, error, fetchAll }
}
