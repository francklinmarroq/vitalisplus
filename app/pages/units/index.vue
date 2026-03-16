<script setup lang="ts">
import type { TableColumn } from '@nuxt/ui'
import type { Unit } from '~/types/unit'

const { units, loading } = useUnits()

const columns: TableColumn<Unit>[] = [
  { accessorKey: 'unit', header: 'Name' },
  { accessorKey: 'actions', header: 'Actions', cell: ({ row }) => {
    // Se renderiza via slot
  } },
]
</script>

<template>
  <div class="mb-3 flex justify-between">
    <h3 class="text-2xl font-bold">
      Cotizaciones
    </h3>
    <div>
      <UButton to="tests/new">
        Crear Nueva
      </UButton>
    </div>
  </div>
  <UCard class="shadow-md shadow-slate-200 flex flex-col min-h-0 flex-1">
    <UTable
      :columns="columns"
      :data="units"
      class="overflow-y-auto"
      style="max-height: calc(100vh - 160px)"
      sticky
      :loading="loading"
    >
      <template #actions-cell="{ row }">
        <UButton
          icon="i-heroicons-pencil-square"
          size="xs"
          color="primary"
          variant="soft"
        />
        <UButton
          icon="i-heroicons-eye"
          size="xs"
          color="neutral"
          variant="soft"
          class="ml-2"
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
