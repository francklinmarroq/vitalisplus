<script setup lang="ts">
import type { TableColumn } from '@nuxt/ui'
import type { Parameter } from '~/types/parameter'

const { parameters, loadingFetchParameters, fetchAllParameters, saveParameter } = useParameters()
const { parameterTypes, loadingFetchParameterTypes, fetchAllParameterTypes } = useParameterTypes()
const { valueTypes, loadingFetchValueTypes, fetchAllValueTypes } = useValueTypes()
const isSaveModalOpen = ref(false)

const columns: TableColumn<Parameter>[] = [
  { accessorKey: 'name', header: 'Name' },
  { accessorKey: 'valueType', header: 'Value Type' },
  { accessorKey: 'parameterType', header: 'Parameter Type' },
  { accessorKey: 'actions', header: 'Actions', cell: ({ row }) => {
    // Se renderiza via slot
  } },
]

const formData = reactive({
  name: '',
  valueTypeId: '',
  parameterTypeId: '',
})

async function handleSave() {
  isSaveModalOpen.value = false
  const parameter: Omit<Parameter, 'id' | 'laboratoryId' | 'parameterType' | 'valueType' | 'label'> = {
    name: formData.name,
    valueTypeId: formData.valueTypeId,
    parameterTypeId: formData.parameterTypeId,
  }
  saveParameter(parameter)
}

onMounted(async () => {
  await fetchAllParameters()
  await fetchAllParameterTypes()
  await fetchAllValueTypes()
})
</script>

<template>
  <div class="mb-3 flex justify-between">
    <h3 class="text-2xl font-bold">
      Parameters
    </h3>
    <div>
      <UModal v-model:open="isSaveModalOpen" title="Create new parameter">
        <UButton label="Create new" @click="isSaveModalOpen = true" />

        <template #body>
          <UForm id="parameterForm" @submit.prevent="handleSave">
            <div class="grid gap-4">
              <UForm>
                <UFormField label="Parameter">
                  <UInput v-model="formData.name" type="text" class="w-full" />
                </UFormField>
                <UFormField label="Value Type">
                  <USelect v-model="formData.parameterTypeId" :loading="loadingFetchParameterTypes" :items="parameterTypes" class="w-full" value-key="id" label-key="name" />
                </UFormField>
                <UFormField label="Value Type">
                  <USelect v-model="formData.valueTypeId" :loading="loadingFetchValueTypes" :items="valueTypes" class="w-full" value-key="id" label-key="name" />
                </UFormField>
              </UForm>
              <UButton type="submit" :loading="loadingSave" label="Save" form="parameterForm" class="justify-center" />
            </div>
          </UForm>
        </template>
      </UModal>
    </div>
  </div>
  <UCard class="shadow-md shadow-slate-200 flex flex-col min-h-0 flex-1">
    <UTable
      :columns="columns"
      :data="parameters"
      class="overflow-y-auto"
      style="max-height: calc(100vh - 160px)"
      sticky
      :loading="loadingFetchParameters"
      empty="No existing parameters. Click on Create New to create a new one."
    >
      <template #actions-cell="{ row }">
        <UButton
          icon="i-heroicons-pencil-square"
          size="xs"
          color="primary"
          variant="soft"
        />
        <UButton
          icon="i-heroicons-trash"
          size="xs"
          color="error"
          variant="soft"
          class="ml-2"
        />
      </template>
    </UTable>
  </UCard>
</template>
