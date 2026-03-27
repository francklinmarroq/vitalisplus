import type { Parameter } from '~/types/parameter'
import { laboratoriesService } from './laboratoriesService'

export const parametersService = {
  async getAll() {
    const supabase = useSupabaseClient()
    const { data, error } = await supabase.from('parameters').select('name, parameter_types (name), value_types (name)')
    if (error) {
      return new Error(`Error in unitsService.getAll: ${error.message}`)
    }
    return data
  },

  async save(parameter: Omit<Parameter, 'id' | 'parameterType' | 'valueType' | 'label'>) {
    const supabase = useSupabaseClient()
    const laboratory = await laboratoriesService.getLaboratory()
    if (!laboratory) {
      throw new Error('No laboratory found')
    }
    parameter.laboratoryId = laboratory.id
    const { data, error } = await supabase.from('parameters').insert({
      laboratory_id: parameter.laboratoryId,
      value_type_id: parameter.valueTypeId,
      parameter_type_id: parameter.parameterTypeId,
      name: parameter.name,
    }).select('name, parameter_types (name), value_types (name)').single()
    if (error) {
      throw new Error(error.message)
    }
    return data
  },
}
