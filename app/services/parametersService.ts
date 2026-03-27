import type { Parameter } from '~/types/parameter'
import { laboratoriesService } from './laboratoriesService'

export const parametersService = {
  async getAll() {
    const supabase = useSupabaseClient()
    const { data, error } = await supabase.from('parameters').select('*')
    if (error) {
      return new Error(`Error in unitsService.getAll: ${error.message}`)
    }
    return data
  },

  async save(parameter: Partial<Parameter>) {
    const supabase = useSupabaseClient()
    const laboratory = await laboratoriesService.getLaboratory()
    if (!laboratory) {
      throw new Error('No laboratory found')
    }
    const { data, error } = await supabase.from('parameters').insert({ laboratory_id: laboratory.id, parameter }).select().single()
    if (error) {
      throw new Error(error.message)
    }
    return data
  },
}
