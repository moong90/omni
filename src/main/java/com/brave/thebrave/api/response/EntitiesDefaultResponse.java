package com.brave.thebrave.api.response;

import com.brave.thebrave.constants.RETURN_CODE;
import com.brave.thebrave.exception.interfaces.CustomException;
import lombok.Data;
import lombok.EqualsAndHashCode;
import lombok.NoArgsConstructor;
import org.springframework.web.HttpRequestMethodNotSupportedException;
import org.springframework.web.bind.MissingServletRequestParameterException;

import java.util.Collection;

@NoArgsConstructor
@Data
@EqualsAndHashCode(callSuper = false)
public class EntitiesDefaultResponse extends DefaultResponse {
    private Collection<Object> entities;

    public EntitiesDefaultResponse(HttpRequestMethodNotSupportedException e) {
        super(e);
    }

    public EntitiesDefaultResponse(MissingServletRequestParameterException e) {
        super(e);
    }

    public EntitiesDefaultResponse(CustomException e) {
        super(e);
    }

    public EntitiesDefaultResponse(RETURN_CODE returnCode) {
        super(returnCode);
    }

    public EntitiesDefaultResponse(RETURN_CODE returnCode, Collection entities) {
        super(returnCode);
        this.setEntities(entities);
    }

	private void setEntities(Collection entities2) {
		// TODO Auto-generated method stub
		
	}
}
