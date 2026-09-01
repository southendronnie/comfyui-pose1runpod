FROM runpod/worker-comfyui:5.8.7-base

ARG CONTROLNET_AUX_COMMIT=59b1fc411ede8623b2997855b8018f0b3b6cf49f

RUN git clone https://github.com/Fannovel16/comfyui_controlnet_aux.git \
      /comfyui/custom_nodes/comfyui_controlnet_aux \
    && cd /comfyui/custom_nodes/comfyui_controlnet_aux \
    && git checkout "${CONTROLNET_AUX_COMMIT}" \
    && uv pip install -r requirements.txt

COPY extra_model_paths.yaml /comfyui/extra_model_paths.yaml

RUN cd /comfyui && timeout 300 python main.py --quick-test-for-ci --cpu

CMD ["/start.sh"]
