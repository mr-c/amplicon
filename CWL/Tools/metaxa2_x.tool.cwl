cwlVersion: v1.0
class: CommandLineTool

label: metaxa2_x
doc:  |
  n/a
    
hints:
  DockerRequirement:
    dockerPull: mgrast/amplicon:1.0
    # dockerPull: mgrast/metaxa:1.0
    
requirements:
  InlineJavascriptRequirement: {}
  
     
baseCommand: [metaxa2_x]
  
stdout: metaxa2_x.log
stderr: metaxa2_x.error


inputs:
  
  input:
    type: File
    format:
      - fasta
    doc: DNA FASTA input file to investigate  
    inputBinding:
      prefix: -i
      
  prefix:
    type: string
    doc: Base for the names of output file(s)
    inputBinding:
      prefix: -o
      
  profile:
    type:
      type: array
      label: Profile set to use for the search 
      items:
        type: enum
        label: profile type
        symbols: [ b, bacteria, a, archaea, e, eukaryota, m, mitochondrial, c, chloroplast, A, all, o, other ]
    default: [all]
    inputBinding:
      valueFrom: |
        ${
          return $self.join() ;
        }
      prefix: -t
    
  complement:
    type: 
      type: enum
      symbols:
        - T
        - F
    doc: |
      Checks both DNA strands against the database, 
      creating reverse complements, on (T) by default 
    default: T
    inputBinding:
      prefix: --complement         
        
  
arguments:   
  - prefix: --cpu
    valueFrom: $(runtime.cores)  
 

outputs:
  profiles:
    type: File
    outputBinding:
      glob: $(inputs.prefix)*
  sam:
    type: stdout
  error: 
    type: stderr  
  

$namespaces:
  Formats: FileFormats.cv.yaml
# s:license: "https://www.apache.org/licenses/LICENSE-2.0"
# s:copyrightHolder: "MG-RAST"