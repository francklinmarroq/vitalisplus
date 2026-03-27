export const parameterTypesService = {
  async getAll() {
    const supabase = useSupabaseClient()
    const { data, error } = await supabase.from('parameter_types').select('id, name')
    if (error) {
      throw new Error(`Error in parameterTypesService.getAll: ${error.message}`)
    }
    return data
  },
}
