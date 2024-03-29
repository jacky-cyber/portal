package com.jspgou.cms.entity.base;

import java.io.Serializable;


/**
 * This is an object that contains data related to the jc_shop_advertise_space table.
 * Do not modify this class because it will be overwritten if the configuration file
 * related to this class is modified.
 *
 * @hibernate.class
 *  table="jc_shop_advertise_space"
 * This class should preserve.
 * @preserve
 */

public abstract class BaseAdspace  implements Serializable {

	public static String REF = "Adspace";
	public static String PROP_NAME = "name";
	public static String PROP_DESCRIPTION = "description";
	public static String PROP_ENABLE = "enable";
	public static String PROP_ID = "id";


	// constructors
	public BaseAdspace () {
		initialize();
	}

	/**
	 * Constructor for primary key
	 */
	public BaseAdspace (java.lang.Integer id) {
		this.setId(id);
		initialize();
	}

	protected void initialize () {}



	private int hashCode = Integer.MIN_VALUE;

	// primary key
	private java.lang.Integer id;

	// fields
	private java.lang.String name;
	private java.lang.String description;
	private java.lang.Boolean enabled;



	/**
	 * Return the unique identifier of this class
     * @hibernate.id
     *  generator-class="native"
     *  column="id"
     */
	public java.lang.Integer getId () {
		return id;
	}

	/**
	 * Set the unique identifier of this class
	 * @param id the new ID
	 */
	public void setId (java.lang.Integer id) {
		this.id = id;
		this.hashCode = Integer.MIN_VALUE;
	}




	/**
	 * Return the value associated with the column: ad_name
	 */
	public java.lang.String getName () {
		return name;
	}

	/**
	 * Set the value related to the column: ad_name
	 * @param name the ad_name value
	 */
	public void setName (java.lang.String name) {
		this.name = name;
	}


	/**
	 * Return the value associated with the column: description
	 */
	public java.lang.String getDescription () {
		return description;
	}

	/**
	 * Set the value related to the column: description
	 * @param description the description value
	 */
	public void setDescription (java.lang.String description) {
		this.description = description;
	}


	/**
	 * Return the value associated with the column: is_enabled
	 */
	public java.lang.Boolean getEnabled () {
		return enabled;
	}

	/**
	 * Set the value related to the column: is_enabled
	 * @param enable the is_enabled value
	 */
	public void setEnabled (java.lang.Boolean enabled) {
		this.enabled = enabled;
	}



	public boolean equals (Object obj) {
		if (null == obj) return false;
		if (!(obj instanceof com.jspgou.cms.entity.Adspace)) return false;
		else {
			com.jspgou.cms.entity.Adspace adspace = (com.jspgou.cms.entity.Adspace) obj;
			if (null == this.getId() || null == adspace.getId()) return false;
			else return (this.getId().equals(adspace.getId()));
		}
	}

	public int hashCode () {
		if (Integer.MIN_VALUE == this.hashCode) {
			if (null == this.getId()) return super.hashCode();
			else {
				String hashStr = this.getClass().getName() + ":" + this.getId().hashCode();
				this.hashCode = hashStr.hashCode();
			}
		}
		return this.hashCode;
	}


	public String toString () {
		return super.toString();
	}


}