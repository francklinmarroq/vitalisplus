<script setup lang="ts">
import type { TableColumn } from '@nuxt/ui'
import type { Parameter } from '~/types/parameter'

const parametersList = ref <Parameter[]>([])

const { testTypeParameters } = useTestTypeParameters()
const { parameters } = useParameters()

const columns: TableColumn<Parameter>[] = [ // TODO:NO HAGAS ESTO INSECTO
  { accessorKey: 'id', header: 'Parameter', cell: ({ row }) => {} },
  { accessorKey: 'unitId', header: 'Unit' },
]

function addEmpyRow() {
  parametersList.value.push({ id: null } as Parameter)
}

function updateSelectedParameter(index: number, selected: Parameter) {
  parametersList.value[index] = selected
}
</script>

<template>
  <div class="grid gap-4">
    <h3 class="text-2xl font-bold">
      New Test Configuration
    </h3>
    <p class="text-neutral-400">
      Create a new test configuration
    </p>
    <div>
      <UCard class="shadow-md shadow-neutral-200">
        <template #header>
          <h4 class="text-lg font-bold">
            Test General Settings
          </h4>
        </template>

        <div class=" grid grid-cols-3 gap-4">
          <UFormField label="Test Name" class="col-span-3">
            <UInput type="text" class="w-full" />
          </UFormField>
        </div>
      </UCard>
    </div>

    <div>
      <UCard class="shadow-md shadow-neutral-200">
        <UTable
          :columns="columns"
          :data="parametersList"
          class="overflow-y-auto"
          style="max-height: calc(100vh - 160px)"
          sticky
          :loading="false"
        >
          <template #id-cell="{ row }">
            <USelectMenu :items="parameters" class="w-full" @update:model-value="(val) => updateSelectedParameter(row.index, val)" />
          </template>
        </UTable>
        <UButton @click="addEmpyRow">
          Agregar Nuevo Parametro
        </UButton>
      </UCard>
    </div>
  </div>
</template>
