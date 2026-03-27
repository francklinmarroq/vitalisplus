<script setup lang="ts">
import type { DropdownMenuItem, NavigationMenuItem } from '@nuxt/ui'

const open = ref(false)
const collapsed = ref(false)

function getItems(expanded: boolean) {
  return [
    {
      label: 'Inicio',
      icon: 'i-lucide-home',
      to: '/dashboard',
    },
    {
      label: 'Test Configuration',
      icon: 'i-lucide-flask-conical',
      children: [
        {
          label: 'Tests',
          to: '/tests',
        },
        {
          label: 'Units',
          to: '/units',
        },
        {
          label: 'Parameters',
          to: '/parameters',
        },
      ],
    },
  ] satisfies NavigationMenuItem[]
}

const user = ref({
  name: 'Benjamin Canac',
  avatar: {
    src: 'https://github.com/benjamincanac.png',
    alt: 'Benjamin Canac',
  },
})

const userItems = computed<DropdownMenuItem[][]>(() => [
  [
    {
      label: 'Profile',
      icon: 'i-lucide-user',
    },
  ],
  [
    {
      label: 'Log out',
      icon: 'i-lucide-log-out',
    },
  ],
])
</script>

<template>
  <UDashboardGroup>
    <UDashboardSidebar
      v-model:open="open"
      v-model:collapsed="collapsed"
      class="shadow-md shadow-slate-200"
      collapsible
      :collapsed-size="0"
      :default-size="15"
    >
      <template #header>
        <div>Nombre Empresa</div>
      </template>

      <template #default="{ collapsed: isCollapsed }">
        <UNavigationMenu
          :key="String(isCollapsed)"
          :items="getItems(!isCollapsed)"
          orientation="vertical"
          :ui="{ link: 'p-1.5 overflow-hidden' }"
        />
      </template>

      <template #footer>
        <UDropdownMenu
          :items="userItems"
          :content="{ align: 'center', collisionPadding: 12 }"
          :ui="{
            content: 'w-(--reka-dropdown-menu-trigger-width) min-w-48',
          }"
        >
          <UButton
            v-bind="user"
            :label="user?.name"
            trailing-icon="i-lucide-chevrons-up-down"
            color="neutral"
            variant="ghost"
            square
            class="w-full data-[state=open]:bg-elevated overflow-hidden"
            :ui="{
              trailingIcon: 'text-dimmed ms-auto',
            }"
          />
        </UDropdownMenu>
      </template>
    </UDashboardSidebar>

    <div class="flex-1 flex flex-col min-w-0">
      <div
        class="h-(--ui-header-height) shrink-0 flex items-center px-4 border-b border-default"
      >
        <UDashboardSidebarCollapse />
      </div>
      <div class="flex-1 overflow-y-auto bf-primary p-8">
        <slot />
      </div>
    </div>
  </UDashboardGroup>
</template>
