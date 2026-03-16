export interface Parameter {
  id: number | null
  name: string
  valueTypeId: number
  lowExpectedValue: number | null
  highExpectedValue: number | null
  referenceText: string | null
  unitId: number | null
  parameterTypeId: number
  label: string
}
