import type { Parameter } from '~/types/parameter'
import { parametersService } from '~/services/parametersService'

export function useParameters() {
  const parameters = ref<Parameter[]>([])
  const loadingFetchParameters = ref(false)
  const loadingSaveParameter = ref(false)
  const error = ref<string | null>(null)

  async function fetchAllParameters() {
    loadingFetchParameters.value = true
    error.value = null
    try {
      const data = await parametersService.getAll()
      parameters.value = data.map(c => ({
        ...c,
        valueType: c.value_types.name,
        parameterType: c.parameter_types.name,
      }))
    }
    catch (err: any) {
      error.value = err.message
    }
    finally {
      loadingFetchParameters.value = false
    }
  }

  async function saveParameter(parameter: Parameter) {
    loadingSaveParameter.value = true
    error.value = null
    try {
      const savedParameter = await parametersService.save(parameter)
      parameters.value.push({ ...savedParameter, valueType: savedParameter.value_types?.name, parameterType: savedParameter.parameter_types?.name })
    }
    catch (err: any) {
      error.value = err.message
    }
    finally {
      loadingSaveParameter.value = false
    }
  }

  return { parameters, loadingFetchParameters, loadingSaveParameter, error, fetchAllParameters, saveParameter }
}
