import type { Unit } from '@/types/unit'
import { unitsService } from '~/services/unitsService'

export function useUnits() {
  const units = ref<Unit[]>([])
  const loading = ref(false)
  const error = ref<string | null>(null)

  async function fetchAll() {
    loading.value = true
    error.value = null
    try {
      const data = await unitsService.getAll()
      units.value = data.map(c => ({ ...c }))
    }
    catch (err: any) {
      error.value = err.message
    }
    finally {
      loading.value = false
    }
  }

  fetchAll()

  return { units, loading, error, fetchAll }
}
