#!/usr/bin/env nextflow
nextflow.enable.dsl=2 


params.outdir = 'output' // Default output directory


process sayHello {
  input: 
    val x
  output:
    stdout
  script:
    """
    echo '$x world!'
    """
}

process helloTask {

    publishDir path: params.outdir, mode: 'copy'
    
    output:
    file "hello.txt"

    script:
    """
    sleep 20
    echo "Hello Lucia" > hello.txt
    sleep 20
    """
}

workflow {
  Channel.of('Bonjour', 'Ciao', 'Hello', 'Hola') | sayHello | view
  helloTask()

}
