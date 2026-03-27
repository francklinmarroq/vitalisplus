export const valueTypesService = {
  async getAll() {
    const supabase = useSupabaseClient()
    const { data, error } = await supabase.from('value_types').select('id, name')
    if (error) {
      throw new Error(`Error in valueTypesService.getAll: ${error.message}`)
    }
    return data
  },
}
