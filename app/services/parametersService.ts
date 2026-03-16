import parameters from '../data/parameters.json'

export const parametersService = {
  async getAll() {
    return parameters
  },
}
