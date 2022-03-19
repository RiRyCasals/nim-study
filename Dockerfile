FROM nimlang/nim:latest
RUN apt update && apt upgrade -y
WORKDIR /work
CMD ["bash"]
