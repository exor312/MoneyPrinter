<script lang="ts" setup>
import { ref } from "vue";
/**
 *
 * GenerateScript
 *
 * @author Reflect-Media <reflect.media GmbH>
 * @version 0.0.1
 *
 * @todo [ ] Test the component
 * @todo [ ] Integration test.
 * @todo [✔] Update the typescript.
 */
const activeTab = ref("script");
const formModel = ref({
  videoSubject: "",
  aiModel: "g4f",
  extraPrompt: "",
});

const formRules = {
  videoSubject: {
    required: true,
    trigger: ["input", "blur"],
  },
  aiModel: {
    required: true,
    trigger: ["change", "blur"],
  },
};
const options = [
  {
    label: "FREE",
    value: "g4f",
  },
  {
    label: "GPT 4",
    value: "gpt4",
  },
  {
    label: "GPT 3.5 Turbo",
    value: "gpt3.5-turbo",
  },
];

const isLoading = ref(false);
const formRef = ref(null);

/*----------  Step 2  ----------*/
const videoModel = ref({
  script: "",
  search: "",
});
const videoRules = {
  script: {
    required: true,
    trigger: ["input", "blur"],
  },
  search: {
    required: true,
    trigger: ["input", "blur"],
  },
};

const HandleGenerateSubject = async () => {
  try {
    isLoading.value = !isLoading.value;
    const { data, pending } = await $fetch(`http://localhost:8080/api/script`, {
      method: "POST",
      body: formModel.value,
    });
    videoModel.value = data.value;

    activeTab.value = "review";
  } catch (error) {
    console.log({ error });
  } finally {
    isLoading.value = false;
  }
};

/*----------  Step 2  ----------*/

const HandleGenerateVideo = async () => {
  try {
    isLoading.value = !isLoading.value;
    const { data, pending } = await $fetch(
      `http://localhost:8080/api/createVideo`,
      {
        method: "POST",
        body: formModel.value,
      }
    );
  } catch (error) {
    console.log({ error });
  } finally {
    isLoading.value = false;
  }
};
</script>

<template>
  <div class="mt-20">
    <n-tabs type="line" animated v-model:value="activeTab">
      <n-tab-pane name="script" tab="Generate script">
        <n-form
          ref="formRef"
          class="max-w-screen-md"
          :model="formModel"
          :rules="formRules"
          size="large"
          :disabled="isLoading"
        >
          <n-form-item label="Model:" path="aiModel">
            <n-select v-model:value="formModel.aiModel" :options="options" />
          </n-form-item>
          <n-form-item label="Video subject:" path="videoSubject">
            <n-input
              v-model:value="formModel.videoSubject"
              placeholder="Video Subject"
              type="textarea"
              show-count
              clearable
              :autosize="{
                minRows: 10,
                maxRows: 20,
              }"
            />
          </n-form-item>
          <n-form-item label="Extra Prompt:">
            <n-input
              v-model:value="formModel.extraPrompt"
              placeholder="Video Subject"
              type="textarea"
              show-count
              clearable
            />
          </n-form-item>
          <n-form-item>
            <n-button
              @click="HandleGenerateSubject"
              type="primary"
              :loading="isLoading"
              :disabled="isLoading"
            >
              Generate script
            </n-button>
          </n-form-item>
        </n-form>
      </n-tab-pane>
      <n-tab-pane name="review" tab="Review script">
        <n-form
          class="max-w-screen-md"
          :model="videoModel"
          :rules="videoRules"
          size="large"
          :loading="isLoading"
        >
          <n-form-item label="Video Script:" path="script">
            <n-input
              v-model:value="videoModel.script"
              placeholder="Video script"
              type="textarea"
              show-count
              clearable
              :autosize="{
                minRows: 10,
                maxRows: 20,
              }"
            />
          </n-form-item>
          <n-form-item label="Search terms:" path="search">
            <n-input
              v-model:value="videoModel.search"
              placeholder="Search terms"
              type="textarea"
              show-count
              clearable
            />
          </n-form-item>
          <n-form-item>
            <n-button
              @click="HandleGenerateVideo"
              type="primary"
              :loading="isLoading"
              :disabled="isLoading"
            >
              Generate the video
            </n-button>
          </n-form-item>
        </n-form>
      </n-tab-pane>
      <n-tab-pane name="audio" tab="Select audio">
        Select audio for the video
      </n-tab-pane>
    </n-tabs>
  </div>
</template>
<style scoped></style>
