export const laboratoriesService = {
  async getLaboratory(): Promise<{ id: string } | null> {
    const supabase = useSupabaseClient()
    const { data: owner, error: sessionError } = await supabase.auth.getSession()

    if (sessionError) {
      throw new Error(`Error in laboratoriesService.getLaboratory: ${sessionError.message}`)
    }

    if (owner.session === null) {
      return null
    }

    const ownerId = owner.session.user.id
    const { data, error } = await supabase.from('laboratories').select('id').eq('owner_id', ownerId).single()
    if (error) {
      throw new Error(`Error in laboratoriesService.getLaboratory: ${error.message}`)
    }
    return data
  },
}
