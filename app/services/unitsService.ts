export const unitsService = {
  async getAll() {
    const supabase = useSupabaseClient()
    const { data, error } = await supabase.from('units').select('*')
    if (error) {
      throw new Error(`Error in unitsService.getAll: ${error.message}`)
    }

    return data
  },
}
