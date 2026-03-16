import tests from '../data/tests.json'

export const testsService = {
  async getAll() {
    return tests
  },
}
