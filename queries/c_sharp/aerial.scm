(interface_declaration
  name: (identifier) @name
  (#set! "kind" "Interface")
  ) @type

(class_declaration
  (modifier)? @accessModifier
  name: (identifier) @name
  (#set! "kind" "Class")
  (#set_if_eq! "private" @accessModifier "private")
  (#set_if_eq! "protected" @accessModifier "protected")
  ) @type

(struct_declaration
  (modifier)? @accessModifier
  name: (identifier) @name
  (#set! "kind" "Struct")
  (#set_if_eq! "private" @accessModifier "private")
  (#set_if_eq! "protected" @accessModifier "protected")
  ) @type

(method_declaration
  (modifier)? @accessModifier
  name: (identifier) @name
  (#set! "kind" "Method")
  (#set_if_eq! "private" @accessModifier "private")
  (#set_if_eq! "protected" @accessModifier "protected")
  ) @type

(enum_declaration
  name: (identifier) @name
  (#set! "kind" "Enum")
  ) @type

(constructor_declaration
  (modifier)? @accessModifier
  name: (identifier) @name
  (#set! "kind" "Constructor")
  (#set_if_eq! "private" @accessModifier "private")
  (#set_if_eq! "protected" @accessModifier "protected")
  ) @type

(property_declaration
  (modifier)? @accessModifier
  name: (identifier) @name
  (#set! "kind" "Property")
  (#set_if_eq! "private" @accessModifier "private")
  (#set_if_eq! "protected" @accessModifier "protected")
  ) @type

(field_declaration
  (modifier)? @accessModifier
   (variable_declaration
    (variable_declarator
       (identifier) @name))
  (#set! "kind" "Field")
  (#set_if_eq! "private" @accessModifier "private")
  (#set_if_eq! "protected" @accessModifier "protected")
   ) @type
