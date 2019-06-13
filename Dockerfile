FROM python:3.6

ENV omorfi 20161115
ENV PYTHONPATH /usr/lib/python3/dist-packages

RUN echo "\nPREPARING\n" && \
    apt-get update && \
    apt-get install -y --no-install-recommends apt-utils lsb-release && \
    #
    #
    echo "\nINSTALLING HFST\n" && \
    wget http://apertium.projectjj.com/apt/apertium-packaging.public.asc -O - \
      | apt-key add - && \
    echo "deb http://apertium.projectjj.com/apt/nightly $(lsb_release -c | cut -f2) main" \
      | tee /etc/apt/sources.list.d/apertium-nightly.list && \
    apt-get update && \
    apt-get install -y --no-install-recommends hfst libhfst52 python3-libhfst zip autoconf automake && \
    #
    #
    echo "\nFIXING HFST\n" && \
    ls /usr/lib/python3/dist-packages/ && \
    ln -s /usr/lib/python3/dist-packages/_libhfst.cpython-35m-x86_64-linux-gnu.so /usr/lib/python3/dist-packages/_libhfst.so && \
    #
    #
    echo "\nINSTALLING OMORFI\n" && \
    wget https://github.com/flammie/omorfi/archive/${omorfi}.tar.gz && \
    tar -xvzf ${omorfi}.tar.gz && \
    cd omorfi-${omorfi} && \
    ls && \
    ./autogen.sh && \
    ./configure && \
    make && \
    make install 
