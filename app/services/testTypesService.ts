import testsTypes from '../data/test_types.json'

export const testTypesService = {
  async getAll() {
    return testsTypes
  },
}
