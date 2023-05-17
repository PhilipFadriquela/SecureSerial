%module( directors="1" ) libSecureSerial
%include "stdint.i"
%include "carrays.i"
%array_class( uint8_t, uint8Array );

%immutable;
%inline %{
    template <typename Type, size_t N>
    struct wrapped_array {
        Type (&data)[N];
        wrapped_array(Type (&data)[N]) : data(data) { }
    };
%}
%mutable;

%{
   #include "include/multiply.h"
   #include "include/ErrorCodes.h"
   #include "include/CommandHJelpers.h"
%}


%extend wrapped_array {
  inline size_t __len__() const { return N; }

  inline const Type& __getitem__(size_t i) const throw(std::out_of_range) {
    if (i >= N || i < 0)
      throw std::out_of_range("out of bounds access");
    return $self->data[i];
  }

  inline void __setitem__(size_t i, const Type& v) throw(std::out_of_range) {
    if (i >= N || i < 0)
      throw std::out_of_range("out of bounds access");
    $self->data[i] = v;
  }
}



#define __attribute__( x )

%include "include/multiply.h"
%include "include/ErrorCodes.h"
%include "include/CommandHelpers.h"

%template( sendReceive ) sendReceive< WhoAmICommand_t >;