import type { Unit } from '@/types/unit'
import { unitsService } from '~/services/unitsService'

export function useUnits() {
  const units = ref<Unit[]>([])
  const loadingFetch = ref(false)
  const loadingSave = ref(false)
  const error = ref<string | null>(null)

  async function fetchAll() {
    loadingFetch.value = true
    error.value = null
    try {
      const data = await unitsService.getAll()
      units.value = data
    }
    catch (err: any) {
      error.value = err.message
    }
    finally {
      loadingFetch.value = false
    }
  }

  async function saveUnit(unitName: string) {
    loadingSave.value = true
    error.value = null
    try {
      const data = await unitsService.save(unitName)
      units.value.push(data)
    }
    catch (err: any) {
      error.value = err.message
    }
    finally {
      loadingSave.value = false
    }
  }
  return { units, loadingFetch, loadingSave, error, fetchAll, saveUnit }
}
