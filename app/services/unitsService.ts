import { laboratoriesService } from './laboratoriesService'

export const unitsService = {
  async getAll() {
    const supabase = useSupabaseClient()
    const { data, error } = await supabase.from('units').select('*')
    if (error) {
      throw new Error(`Error in unitsService.getAll: ${error.message}`)
    }

    return data
  },

  async save(unitName: string) {
    const supabase = useSupabaseClient()
    const laboratory = await laboratoriesService.getLaboratory()
    if (!laboratory) {
      throw new Error('No laboratory found')
    }
    const { data, error } = await supabase.from('units').insert({ laboratory_id: laboratory.id, unit: unitName }).select().single()
    if (error) {
      throw new Error(error.message)
    }
    return data
  },
}
