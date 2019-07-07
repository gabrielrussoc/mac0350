import { useState } from 'react';

const useForm = (callback: Function) => {

  const [values, setValues]: any = useState({});

  const handleSubmit = (event: any) => {
    if (event) event.preventDefault();
    callback();
  };

  const handleChange = (event: any) => {
    event.persist();
    setValues((values: any) => ({ ...values, [event.target.name]: event.target.value }));
  };

  return {
    handleChange,
    handleSubmit,
    values,
  }
};

export default useForm;