import React, { useState, useEffect } from 'react';
import './accordion.css';
import FAQsService from './faqsService.js';
import debug from "sabio-debug";
import { mapLookUpItem } from '../../helpers/utils';
import lookUpService from '../../services/lookUpService';
import { useNavigate } from 'react-router-dom';
import toastr from 'toastr';



const _logger = debug.extend("Accordion");

function Accordion() {
  
  const [activeIndex, setActiveIndex] = useState(null);

  const [faqData, setFaqData] = useState({
    faqsArray:[],
    faqsArrayMapped:[]
  });
  
  const navigate = useNavigate()

  const toggleAccordion = (index) => {
    setActiveIndex(index === activeIndex ? null : index);
  };

  const faqsMapper = (faq) => {
    return { id: faq.id, question: faq.question, answer: faq.answer, categoryId: faq.categoryId }
  };

  const onGetFAQsSuccess = (response) => {
    _logger("onGetFAQsSuccess: ", response.items);
    let newFAQsArray = response.items;

    setFaqData((prevState) => {
      const newFAQsArrayObj = { ...prevState };
      newFAQsArrayObj.faqsArray = newFAQsArray;
      newFAQsArrayObj.faqsArrayMapped = newFAQsArray.map(faqsMapper);
      return newFAQsArrayObj;
    });
  };

  const onGetFAQsError = (error) => {
    _logger(error)
    toastr.error("Error occured loading FAQ")
  };

  useEffect(() => {
    _logger("Firing useEffect for getFAQs");

    FAQsService.getFAQs()
      .then(onGetFAQsSuccess)
      .catch(onGetFAQsError);
  }, []);

  const [lookUpData, setLookUpData] = useState({
    categoryId:[],
    mappedCategoryId:[],
  });

  const onLookUpSuccess = (response) => {
    _logger(response, "onLookUpSuccess");
    let categoryId = response.item.faqCategories;

    setLookUpData((prevState) => {
      const newState = { ...prevState };
      newState.categoryId = categoryId;
      newState.mappedCategoryId = categoryId.map(mapLookUpItem);
      return newState;
    });
  };

  const onLookUpError = (error) => {
    _logger(error, "onLookUpError");
    toastr.error("Error occured loading Category")
  };

  useEffect(() => {
    lookUpService.LookUp(["FAQCategories"])
      .then(onLookUpSuccess)
      .catch(onLookUpError)
  }, []);

  const clickHandler = (event) => {
    let value = event.target.value;
    let newCategoryId = parseInt(value)
    

    setFaqData((prevState) => {
      const newState = { ...prevState };
      let filteredFaqsArray = [...newState.faqsArray]
      
      if (value !== "showALL"){
       filteredFaqsArray = newState.faqsArray.filter((faq) => {
        return faq.categoryId.id === newCategoryId;
      });}
      newState.faqsArrayMapped = filteredFaqsArray.map(faqsMapper);
      return newState;
    });
  };

  const onHomeClick = () =>{
    _logger("onHomeClick", onHomeClick);
    navigate("/")
  };

  const renderFAQItems = () => {
    const renderFaqItem = (faq, index) => {
      return (
        <React.Fragment key={faq.id}>
          <button className={`accordion-btn ${activeIndex === index ? "active" : ''}`}
          onClick={toggleAccordion.bind(null, index)}>
            {faq.question}
          </button>
          <div className={`accordion-content ${activeIndex === index ? "active" : ''}`}>
            <p>{faq.answer}</p>
          </div>
        </React.Fragment>
      );
    };
  
    return faqData.faqsArrayMapped.map((faq, index) => renderFaqItem(faq, index));
  };

  return (
    <div className="accordion">
      <div className="accordion-container">
      <div className="filter-container">
        <button type="Go to" className="home-button" onClick={onHomeClick}>Home</button>
      <select onChange={clickHandler} className="select" aria-label="Default select example">
        <option value = "showALL">Show All</option> 
        {lookUpData.mappedCategoryId}
      </select>
      </div>
        {renderFAQItems()}
        {faqData.faqsArrayMapped.length === 0 && (
          <div>No FAQs found for the selected category.</div>
        )}
      </div>
    </div>
  );  
}

export default Accordion;
