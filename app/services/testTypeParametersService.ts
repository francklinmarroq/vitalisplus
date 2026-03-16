import testTypesParameters from '../data/test_types_parameters.json'

export const testTypeParametersService = {
  async getAll() {
    return testTypesParameters
  },
}
