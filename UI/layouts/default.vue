<script lang="ts" setup>
/**
 *
 * Component Description:Desc
 *
 * @author Reflect-Media <reflect.media GmbH>
 * @version 0.0.1
 *
 * @todo [ ] Test the component
 * @todo [ ] Integration test.
 * @todo [✔] Update the typescript.
 */
import { h } from "vue";
import { NIcon } from "naive-ui";
import { Icon, NuxtLink } from "#components";

function renderIcon(iconName: string = "uil:twitter") {
  return () => h(Icon, { name: iconName });
}
const menuOptions = [
  {
    label: () =>
      h(
        NuxtLink,
        {
          to: "/",
          activeClass: "text-green-800",
          exactActiveClass: "text-green-800",
        },
        { default: () => "Generate script" }
      ),
    key: "step-1",
    icon: renderIcon("gis:flag"),
  },
  {
    label: "Review script",
    key: "step-2",
    icon: renderIcon("basil:edit-alt-outline"),
    children: [
      {
        label: "Rat",
        key: "rat",
      },
    ],
  },
];
</script>

<template>
  <naive-config>
    <n-layout has-sider position="absolute">
      <n-layout-sider
        bordered
        show-trigger
        collapse-mode="width"
        :collapsed-width="64"
        :width="240"
        :native-scrollbar="false"
        style="max-height: 320px"
      >
        <n-menu
          :collapsed-width="64"
          :collapsed-icon-size="22"
          :options="menuOptions"
        />
      </n-layout-sider>
      <n-layout class="min-h-screen bg-gray-100">
        <slot></slot>
      </n-layout>
    </n-layout>
  </naive-config>
</template>
<style scoped></style>
