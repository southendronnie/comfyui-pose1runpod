FROM runpod/worker-comfyui:5.9.0-base

ARG CONTROLNET_AUX_COMMIT=59b1fc411ede8623b2997855b8018f0b3b6cf49f
ARG IPADAPTER_PLUS_COMMIT=a0f451a5113cf9becb0847b92884cb10cbdec0ef

RUN git clone https://github.com/Fannovel16/comfyui_controlnet_aux.git \
      /comfyui/custom_nodes/comfyui_controlnet_aux \
    && cd /comfyui/custom_nodes/comfyui_controlnet_aux \
    && git checkout "${CONTROLNET_AUX_COMMIT}" \
    && uv pip install -r requirements.txt

RUN git clone https://github.com/cubiq/ComfyUI_IPAdapter_plus.git \
      /comfyui/custom_nodes/ComfyUI_IPAdapter_plus \
    && cd /comfyui/custom_nodes/ComfyUI_IPAdapter_plus \
    && git checkout "${IPADAPTER_PLUS_COMMIT}" \
    && uv pip install insightface onnxruntime

COPY extra_model_paths.yaml /comfyui/extra_model_paths.yaml

RUN cd /comfyui && timeout 300 python main.py --quick-test-for-ci --cpu

CMD ["/start.sh"]
